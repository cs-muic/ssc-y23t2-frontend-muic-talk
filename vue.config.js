const { defineConfig } = require("@vue/cli-service");
module.exports = defineConfig({
  transpileDependencies: ["vuetify"],
  devServer: {
    host: "localhost",
    allowedHosts: "all",
    port: 8080,
    https: false,
    proxy: {
      "/api": {
        target: "http://localhost:8081",
      },
      "/user": {
        target: "http://localhost:8081",
      },
    },
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS",
      "Access-Control-Allow-Headers":
        "X-Requested-With, content-type, Authorization",
    },
  },
});
