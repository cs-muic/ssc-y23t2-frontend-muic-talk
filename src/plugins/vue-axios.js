import * as Vue from "vue"; // in Vue 3
import axios from "axios";
import VueAxios from "vue-axios";
import App from "../App.vue";

const app = Vue.createApp(App);
app.use(VueAxios, axios);
