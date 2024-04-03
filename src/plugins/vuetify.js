import Vue from "vue";
import Vuetify from "vuetify/lib/framework";

Vue.use(Vuetify);

export default new Vuetify({
  theme: {
    themes: {
      light: {
        primary: "#6a0dad",
        secondary: "#6a0dad",
        accent: "#6a0dad",
        error: "#C41E3A",
      },
    },
  },
});
