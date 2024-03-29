import Vue from "vue";
import VueRouter from "vue-router";
import HomeView from "../views/HomeView.vue";
import store from "@/store";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "home",
    component: HomeView,
  },
  {
    path: "/about",
    name: "about",
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () =>
      import(/* webpackChunkName: "about" */ "../views/AboutView.vue"),
  },
  {
    path: "/login",
    name: "login",
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () =>
      import(/* webpackChunkName: "about" */ "../views/LoginView.vue"),
  },
  {
    path: "/schedule",
    name: "schedule",
    component: () =>
        import(/* webpackChunkName: "about" */ "../views/ScheduleView.vue"),
  },
];

const router = new VueRouter({
  routes,
});

router.beforeEach(async (to, from, next) => {
  let response = await Vue.axios.get("/api/whoami");
  // response.data is our payload
  await store.dispatch("setLoggedInUser", response.data);
  let isLoggedIn = store.state.isLoggedIn;
  // make surer if user is lggged in, it will not see homepage
  if (to.name === "login" && isLoggedIn) {
    next({ name: "home" });
  }
  console.log(isLoggedIn);
  //if the name of the router is not Login, it needs authorization to access the page
  if (to.name !== "login" && !isLoggedIn) {
    //redirect to login page
    next({ name: "login" });
  } else {
    // otherwise, let it go
    next();
  }
});

export default router;
