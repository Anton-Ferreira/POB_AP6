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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
            request.getRequestDispatcher(path).forward(request, response);
            return;
        }

        String action = extractAction(path);
        
        // Roteamento de ações
        switch(action) {
            case "inicio":
            case "":
                forwardToView(request, response, "index.jsp");
                break;
            case "especies":
                forwardToView(request, response, "especies.jsp");
                break;
            case "cuidados":
                forwardToView(request, response, "cuidados.jsp");
                break;
            case "wiki":
                forwardToView(request, response, "wiki.jsp");
                break;
            case "mapa":
                forwardToView(request, response, "mapa.jsp");
                break;
            case "legalizacao":
                forwardToView(request, response, "legalizacao.jsp");
                break;
            case "alimentacao":
                forwardToView(request, response, "alimentacao.jsp");
                break;
            case "calopsita":
                forwardToView(request, response, "calopsita.jsp");
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
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

    /**
     * Encaminha para a view (JSP) em WebContent/pages/
     */
    private void forwardToView(HttpServletRequest request, HttpServletResponse response,
                               String viewName) throws ServletException, IOException {
        request.getRequestDispatcher(VIEWS_PREFIX + viewName)
               .forward(request, response);
    }
}
