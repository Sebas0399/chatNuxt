import axios from "axios"
const runtimeConfig = useRuntimeConfig()
export const getContactsByCompany = async (id) => {
  const apiBase = runtimeConfig.public.apiBase
  const response = await axios.get(`${apiBase}/contacts/company/${id}`)
  return response.data
}