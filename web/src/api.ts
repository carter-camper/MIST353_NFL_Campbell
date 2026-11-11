const API_URL = import.meta.env.VITE_API_URL ?? "http://localhost:8000";

export async function fetchData(endpoint: string, params: Record<string, string> = {}) {
  const res = await fetch(`${API_URL}/${endpoint}?${new URLSearchParams(params)}`);
  if (!res.ok) throw new Error(`Error ${res.status}`);
  return (await res.json()).data ?? [];
}