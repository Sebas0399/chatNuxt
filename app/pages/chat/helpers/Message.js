import axios from "axios"
const runtimeConfig = useRuntimeConfig()
export const getMessagesByContact = async (id) => {
  const apiBase = runtimeConfig.public.apiBase
  const response = await axios.get(`${apiBase}/messages/contact/${id}`)
  return response.data
}