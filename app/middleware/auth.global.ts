export default defineNuxtRouteMiddleware((to, from) => {
  const auth = useAuthStore(); // Or any other auth technique
  const publicRoutes = new Set(['/login', '/register', '/forgot-password']);
  if (to.meta.auth === false || publicRoutes.has(to.path)) {
    // Optional: redirect authenticated users away from /login
    if (to.path === '/login' && auth.isAuthenticated) {
      return navigateTo('/dashboard'); // Redirect to a dashboard or home page
    }
    return;
  }

  /*if (!auth.isAuthenticated) {
    return navigateTo({ path: '/login', query: { redirect: to.fullPath } });
  }*/
});