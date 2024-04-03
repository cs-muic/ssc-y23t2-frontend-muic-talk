const { createProxyMiddleware } = require("http-proxy-middleware");

module.exports = function (app) {
  app.use(
    "/api",
    createProxyMiddleware({
      target: "http://localhost:8081",
      changeOrigin: true,
    })
  );
  app.use();
  "/user",
    createProxyMiddleware({
      target: "http://localhost:8081",
      changeOrigin: true,
    });
};
