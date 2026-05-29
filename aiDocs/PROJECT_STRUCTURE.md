# Estrutura do Projeto - POB_AP6

## Organização MVC (similar ao Django)

```
POB_AP6/
├── src/                          # Código-fonte Java
│   ├── controllers/              # Servlets (Controllers)
│   │   └── AppServlet.java      # Front Controller principal
│   ├── models/                   # Modelos de dados
│   │   ├── dao/                  # Data Access Objects
│   │   │   └── AveDAO.java      # DAO para manipular dados de aves
│   │   └── Ave.java             # Modelo/Entity de Ave
│   ├── utils/                    # Classes utilitárias
│   │   ├── ConnectionDB.java    # Gerenciador de conexão com BD
│   │   └── ValidationUtils.java # Utilitários de validação
│   └── config/                   # Configurações
│       └── AppConfig.java        # Configurações da aplicação
│
├── views/                        # Templates e páginas JSP
│   ├── pages/                    # Páginas JSP (convertidas do HTML)
│   │   ├── index.jsp
│   │   ├── especies.jsp
│   │   ├── cuidados.jsp
│   │   ├── wiki.jsp
│   │   ├── mapa.jsp
│   │   └── legalizacao.jsp
│   ├── layouts/                  # Templates reutilizáveis
│   │   ├── header.jsp
│   │   ├── footer.jsp
│   │   └── base.jsp
│   └── components/               # Componentes reutilizáveis
│       └── navbar.jsp
│
├── resources/                    # Recursos estáticos
│   ├── styles/                   # CSS (do pages/styles)
│   ├── scripts/                  # JavaScript (do pages/scripts)
│   └── images/                   # Imagens
│
├── WebContent/                   # Raiz do projeto web (se usando IDE)
│   └── WEB-INF/
│       └── web.xml              # Descritores do servlet
│
├── pages/                        # (ORIGINAL - será descontinuado)
│
└── README.md                     # Documentação do projeto
```

## Padrões de Projeto Implementados

1. **Front Controller (AppServlet)** - Centraliza o roteamento de requisições
2. **DAO (Data Access Object)** - Encapsula a lógica de acesso ao banco de dados
3. (Adicionar segundo padrão conforme arquitetura evoluir)

## Próximos Passos

- [ ] Converter arquivos HTML em JSP
- [ ] Implementar AveDAO para persistência de dados
- [ ] Configurar banco de dados
- [ ] Implementar MapsAPI integration
- [ ] Adicionar segundo padrão de projeto
