export default {
  namespaced: true,
  state: {
    token: ''
  },
  mutations: {
    setToken (state, token) {
      state.token = token
    },
    clearToken (state) {
      state.token = ''
    }
  }
}
