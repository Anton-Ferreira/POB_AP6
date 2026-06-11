/*
 * Arquivo: src/controllers/AppServlet.java
 * 
 * Descrição:
 * Servlet principal que atua como Front Controller centralizado
 * Processa todas as requisições HTTP e encaminha para as views apropriadas
 * 
 * Padrão de Projeto: Front Controller
 */

package controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Ave;
import models.AveQuizPerfil;
import models.dao.AveDAO;
import utils.GoogleMapsConfig;

/**
 * Controlador principal da aplicação
 * Similar ao URLRouter do Django
 */
public class AppServlet extends HttpServlet {

    private static final String VIEWS_PREFIX = "/pages/";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = getPathWithinContext(request);

        if (isStaticAsset(path)) {
            // Servlet mapeado em "/" intercepta tudo; delega ao default do Tomcat.
            getServletContext().getNamedDispatcher("default").forward(request, response);
            return;
        }

        String action = extractAction(path);
        
        // Roteamento de ações
        switch(action) {
            case "inicio":
            case "":
                carregarQuiz(request);
                forwardToView(request, response, "index.jsp", action);
                break;
            case "especies":
                carregarEspecies(request, null);
                forwardToView(request, response, "especies.jsp", action);
                break;
            case "aves-pequenas":
                carregarEspecies(request, "pequenas");
                forwardToView(request, response, "especies.jsp", action);
                break;
            case "aves-medias":
                carregarEspecies(request, "medias");
                forwardToView(request, response, "especies.jsp", action);
                break;
            case "cuidados":
                forwardToView(request, response, "cuidados.jsp", action);
                break;
            case "wiki":
                carregarWiki(request);
                forwardToView(request, response, "wiki.jsp", action);
                break;
            case "mapa":
                carregarMapa(request);
                forwardToView(request, response, "mapa.jsp", action);
                break;
            case "legalizacao":
                forwardToView(request, response, "legalizacao.jsp", action);
                break;
            case "alimentacao":
                forwardToView(request, response, "alimentacao.jsp", action);
                break;
            case "pesquisar":
                pesquisarEspecie(request, response);
                break;
            default:
                if (carregarEspecie(request, action)) {
                    forwardToView(request, response, "calopsita.jsp", action);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                }
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    private String getPathWithinContext(HttpServletRequest request) {
        String uri = request.getRequestURI();
        String contextPath = request.getContextPath();
        if (uri.startsWith(contextPath)) {
            uri = uri.substring(contextPath.length());
        }
        return uri.isEmpty() ? "/" : uri;
    }

    private boolean isStaticAsset(String path) {
        return path.startsWith("/pages/styles/") || path.startsWith("/pages/scripts/");
    }

    /**
     * Extrai a primeira parte do path como ação (ex.: /especies → especies)
     */
    private String extractAction(String path) {
        if (path == null || path.equals("/")) {
            return "";
        }
        String trimmed = path.startsWith("/") ? path.substring(1) : path;
        int slash = trimmed.indexOf('/');
        String segment = slash >= 0 ? trimmed.substring(0, slash) : trimmed;
        return segment.replace(".do", "").replace(".jsp", "");
    }

    private void carregarEspecies(HttpServletRequest request, String categoriaFiltro) {
        List<Ave> avesPequenas = new ArrayList<>();
        List<Ave> avesMedias = new ArrayList<>();

        try {
            AveDAO dao = new AveDAO();
            for (Ave ave : dao.buscarTodas()) {
                if (ave.isPequena()) {
                    avesPequenas.add(ave);
                } else {
                    avesMedias.add(ave);
                }
            }
        } catch (Exception e) {
            request.setAttribute("erroEspecies",
                    "Não foi possível carregar as espécies do banco de dados.");
            e.printStackTrace();
        }

        request.setAttribute("categoriaFiltro", categoriaFiltro);
        request.setAttribute("avesPequenas", avesPequenas);
        request.setAttribute("avesMedias", avesMedias);
    }

    private void carregarMapa(HttpServletRequest request) {
        request.setAttribute("googleMapsApiKey", GoogleMapsConfig.getApiKey());
    }

    private void carregarWiki(HttpServletRequest request) {
        try {
            AveDAO dao = new AveDAO();
            dao.buscarAleatoria().ifPresent(ave -> request.setAttribute("especieDestaque", ave));
            request.setAttribute("especiesPopulares", dao.buscarPopulares());
        } catch (Exception e) {
            request.setAttribute("erroWiki",
                    "Não foi possível carregar as espécies da wiki.");
            e.printStackTrace();
        }
    }

    private void carregarQuiz(HttpServletRequest request) {
        try {
            String contextPath = request.getContextPath();
            List<AveQuizPerfil> perfis = new ArrayList<>();

            for (Ave ave : new AveDAO().buscarTodas()) {
                perfis.add(AveQuizPerfil.from(ave, contextPath));
            }

            request.setAttribute("avesQuizJson", new Gson().toJson(perfis));
        } catch (Exception e) {
            request.setAttribute("avesQuizJson", "[]");
            request.setAttribute("erroQuiz",
                    "Não foi possível carregar as espécies para o quiz.");
            e.printStackTrace();
        }
    }

    private boolean carregarEspecie(HttpServletRequest request, String slug) {
        try {
            AveDAO dao = new AveDAO();
            return dao.buscarPorSlug(slug)
                    .map(ave -> {
                        request.setAttribute("ave", ave);
                        return true;
                    })
                    .orElse(false);
        } catch (Exception e) {
            request.setAttribute("erroEspecie",
                    "Não foi possível carregar as informações desta espécie.");
            e.printStackTrace();
            return false;
        }
    }

    private void pesquisarEspecie(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String termo = request.getParameter("termo");
        String origem = request.getParameter("origem");
        boolean respostaJson = aceitaJson(request);

        if (termo == null || termo.isBlank()) {
            responderPesquisaNaoEncontrada(request, response, origem, respostaJson);
            return;
        }

        try {
            Optional<Ave> ave = new AveDAO().buscarPorNome(termo.trim());

            if (ave.isPresent()) {
                String urlDestino = request.getContextPath() + ave.get().getArtigoPath();

                if (respostaJson) {
                    response.setContentType("application/json;charset=UTF-8");
                    JsonObject json = new JsonObject();
                    json.addProperty("found", true);
                    json.addProperty("url", urlDestino);
                    response.getWriter().write(json.toString());
                } else {
                    response.sendRedirect(urlDestino);
                }
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        responderPesquisaNaoEncontrada(request, response, origem, respostaJson);
    }

    private void responderPesquisaNaoEncontrada(HttpServletRequest request,
                                              HttpServletResponse response,
                                              String origem,
                                              boolean respostaJson) throws IOException {
        if (respostaJson) {
            response.setContentType("application/json;charset=UTF-8");
            JsonObject json = new JsonObject();
            json.addProperty("found", false);
            response.getWriter().write(json.toString());
            return;
        }

        String destino = origem;
        if (destino == null || destino.isBlank()) {
            destino = request.getContextPath() + "/wiki";
        }

        String separador = destino.contains("?") ? "&" : "?";
        response.sendRedirect(destino + separador + "pesquisaErro=1");
    }

    private boolean aceitaJson(HttpServletRequest request) {
        String accept = request.getHeader("Accept");
        return accept != null && accept.contains("application/json");
    }

    private void definirNavegacao(HttpServletRequest request, String action) {
        request.setAttribute("navSite", resolverNavSite(action));
        request.setAttribute("navWiki", resolverNavWiki(action));
    }

    private String resolverNavSite(String action) {
        if (action == null || action.isEmpty() || "inicio".equals(action)) {
            return "inicio";
        }
        if ("mapa".equals(action)) {
            return "mapa";
        }
        if (isPaginaWiki(action)) {
            return "wiki";
        }
        return "wiki";
    }

    private String resolverNavWiki(String action) {
        if (action == null || action.isEmpty()) {
            return "";
        }

        return switch (action) {
            case "wiki" -> "wiki";
            case "especies", "aves-pequenas", "aves-medias" -> "especies";
            case "cuidados" -> "cuidados";
            case "alimentacao" -> "alimentacao";
            case "legalizacao" -> "legalizacao";
            default -> isPaginaWiki(action) ? "" : "especies";
        };
    }

    private boolean isPaginaWiki(String action) {
        return switch (action) {
            case "wiki", "especies", "aves-pequenas", "aves-medias",
                 "cuidados", "alimentacao", "legalizacao" -> true;
            default -> false;
        };
    }

    /**
     * Encaminha para a view (JSP) em WebContent/pages/
     */
    private void forwardToView(HttpServletRequest request, HttpServletResponse response,
                               String viewName, String action) throws ServletException, IOException {
        definirNavegacao(request, action);
        request.getRequestDispatcher(VIEWS_PREFIX + viewName)
               .forward(request, response);
    }
}
