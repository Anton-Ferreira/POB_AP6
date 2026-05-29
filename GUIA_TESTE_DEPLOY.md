# 🚀 Guia de Teste - Deploy e Testes do POB_AP6

## Pré-requisitos

Antes de testar no Tomcat, você precisa de:

✅ Java JDK 8+ instalado
✅ Apache Tomcat 9+ instalado
✅ Um IDE (Eclipse, IntelliJ) OU conhecimento de compilação via CLI

---

## 📋 Checklist Antes de Testar

### 1. **Compilar Arquivos Java**

Seus arquivos Java precisam ser compilados para .class:

```
AppServlet.java          → AppServlet.class
Ave.java                 → Ave.class
AveDAO.java              → AveDAO.class
ConnectionDB.java        → ConnectionDB.class
```

**Onde colocar:**
```
Tomcat/webapps/POB_AP6/
├── WEB-INF/
│   ├── classes/
│   │   ├── controllers/
│   │   │   └── AppServlet.class
│   │   ├── models/
│   │   │   ├── Ave.class
│   │   │   └── dao/
│   │   │       └── AveDAO.class
│   │   └── utils/
│   │       └── ConnectionDB.class
│   ├── lib/
│   │   └── mysql-connector-java-8.0.33.jar (driver MySQL)
│   └── web.xml
├── pages/
│   ├── styles/
│   ├── scripts/
│   ├── index.jsp
│   ├── especies.jsp
│   └── ...
└── index.jsp (opcional, para redirect)
```

---

## 🔧 Opção 1: Compilação via IDE (RECOMENDADO)

### Se usando Eclipse:

1. **Criar novo Dynamic Web Project**
   - File → New → Dynamic Web Project
   - Nome: `POB_AP6`
   - Target runtime: Apache Tomcat 9

2. **Copiar seus arquivos**
   ```
   src/
   ├── controllers/AppServlet.java
   ├── models/Ave.java
   ├── models/dao/AveDAO.java
   └── utils/ConnectionDB.java
   ```

3. **Copiar JSPs e recursos**
   ```
   WebContent/
   ├── WEB-INF/web.xml
   ├── pages/
   │   ├── index.jsp
   │   ├── styles/
   │   └── scripts/
   ```

4. **Add Libraries**
   - Right-click project → Build Path → Add External Archives
   - Adicionar `mysql-connector-java-8.0.33.jar`

5. **Compilar**
   - Project → Clean
   - Project → Build All

6. **Deploy**
   - Right-click → Run on Server
   - Selecionar Tomcat 9
   - Clique em Finish

---

## 🔧 Opção 2: Compilação via CLI (avançado)

```bash
# 1. Compilar Java
javac -d build/classes -cp src src/controllers/AppServlet.java
javac -d build/classes -cp src src/models/Ave.java
javac -d build/classes -cp src:lib/mysql-connector-java-8.0.33.jar src/models/dao/AveDAO.java
javac -d build/classes -cp src src/utils/ConnectionDB.java

# 2. Criar WAR
jar cvf POB_AP6.war -C build/classes . -C WebContent .

# 3. Deploy
cp POB_AP6.war $CATALINA_HOME/webapps/

# 4. Iniciar Tomcat
$CATALINA_HOME/bin/startup.sh (Linux/Mac)
# ou
%CATALINA_HOME%\bin\startup.bat (Windows)
```

---

## ✅ Testando no Navegador

Após deploy bem-sucedido, acesse:

### URL Base
```
http://localhost:8080/POB_AP6/
```

### Rotas Disponíveis
```
✅ http://localhost:8080/POB_AP6/                 → Home (index.jsp)
✅ http://localhost:8080/POB_AP6/wiki             → Wiki (wiki.jsp)
✅ http://localhost:8080/POB_AP6/especies         → Espécies (especies.jsp)
✅ http://localhost:8080/POB_AP6/cuidados         → Cuidados (cuidados.jsp)
✅ http://localhost:8080/POB_AP6/alimentacao      → Alimentação (alimentacao.jsp)
✅ http://localhost:8080/POB_AP6/legalizacao      → Legalização (legalizacao.jsp)
✅ http://localhost:8080/POB_AP6/calopsita        → Calopsita (calopsita.jsp)
✅ http://localhost:8080/POB_AP6/mapa             → Mapa (mapa.jsp)
```

---

## 🧪 Testes a Realizar

### 1. **Teste de Navegação**
- [ ] Acessar http://localhost:8080/POB_AP6/
- [ ] Verificar se a página carrega
- [ ] Verificar se CSS está aplicado
- [ ] Clicar em "Explorar Espécies"
- [ ] Deve ir para `/especies`

### 2. **Teste de Links Internos**
- [ ] Clique em cada link do menu:
  - [ ] Início
  - [ ] Espécies
  - [ ] Mapa
  - [ ] Quiz (scroll interno)
- [ ] Cada link deve funcionar sem erros

### 3. **Teste de Recursos Estáticos**
- [ ] CSS deve estar visível (cores, fontes, layout)
- [ ] Imagens devem carregar
- [ ] Scripts devem funcionar (quiz, filtros do mapa)

### 4. **Teste de Erros 404**
- [ ] Acessar http://localhost:8080/POB_AP6/pagina-inexistente
- [ ] Deve mostrar página de erro (ou redirecionar para home)

---

## 🐛 Possíveis Problemas e Soluções

### Problema: "HTTP 404 - Página não encontrada"
**Solução:**
```
1. Verificar se web.xml está em WebContent/WEB-INF/web.xml
2. Verificar se AppServlet.java foi compilado
3. Reiniciar Tomcat
4. Limpar cache do navegador (Ctrl+Shift+Delete)
```

### Problema: "ClassNotFoundException: controllers.AppServlet"
**Solução:**
```
1. Verificar se AppServlet.class está em WEB-INF/classes/controllers/
2. Recompilar: Project → Clean → Build All
3. Redeploy
```

### Problema: "CSS não carrega ou aparece sem estilo"
**Solução:**
```
1. Verificar se pages/styles/ existe com os arquivos CSS
2. Verificar paths nos JSPs: ${pageContext.request.contextPath}/pages/styles/
3. Abrir Developer Tools (F12) → Network → verificar se CSS retorna 200 OK
```

### Problema: "Erro ao compilar: package javax.servlet não encontrado"
**Solução:**
```
1. Adicionar servlet-api.jar ao classpath
2. No Eclipse: Project → Properties → Java Build Path → Add Library → 
   Apache Tomcat 9.0 → Finish
```

---

## 📊 Fluxo Esperado

```
Navegador                    Tomcat                      JSP
───────────────────────────────────────────────────────────────

GET /
    │
    └──→ web.xml mapeia "/" para AppServlet
         │
         └──→ AppServlet.doGet() → extractAction()
              │
              └──→ forwardToView(..., "index.jsp")
                   │
                   └──→ Renderiza: views/pages/index.jsp
                        │
                        └──→ Retorna HTML renderizado
                             │
                             └──→ Navegador exibe página
```

---

## ✨ Checklist Final Antes de Testar

- [ ] Todos os arquivos Java compilados?
- [ ] web.xml está em WebContent/WEB-INF/?
- [ ] JSPs estão em views/pages/?
- [ ] CSS/JS estão em pages/styles/ e pages/scripts/?
- [ ] MySQL driver está em WEB-INF/lib/?
- [ ] AppServlet mapeia todas as rotas?
- [ ] Tomcat está iniciado?

---

## 🎯 Resumo: O Que Você Precisa Fazer

### Cenário Ideal (Com IDE):
1. **Eclipse** → New Dynamic Web Project
2. Copiar arquivos Java em `src/`
3. Copiar JSPs em `WebContent/pages/`
4. Right-click → Run on Server
5. Abrir navegador: `http://localhost:8080/POB_AP6/`

### Cenário Sem IDE:
1. Compilar Java manualmente
2. Criar estrutura em `Tomcat/webapps/POB_AP6/`
3. Iniciar Tomcat
4. Acessar navegador

---

## 📞 Debug: Como Saber Se Está Funcionando?

✅ **Está funcionando se:**
- Página carrega sem erro 404
- Menu funciona
- Estilos CSS aparecem
- Cada link redireciona para a página correta

❌ **Não está funcionando se:**
- Erro 404 na página inicial
- ClassNotFoundException no console do Tomcat
- Página em branco
- Links não funcionam

---

**PRÓXIMO PASSO**: Escolha sua opção de IDE/CLI e comece o deploy! 🚀
