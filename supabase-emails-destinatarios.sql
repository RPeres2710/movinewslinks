-- Lista de e-mails que recebem os boletins (aba "E-mails" do painel).
-- Rodar uma vez no Supabase: SQL Editor > New query > colar > Run.
create table if not exists public.emails_destinatarios (
  id uuid primary key default gen_random_uuid(),
  email text not null unique,
  criado_em timestamptz not null default now(),
  criado_por uuid default auth.uid()
);

alter table public.emails_destinatarios enable row level security;

-- Somente usuários logados no painel (nada público).
create policy emails_dest_select_autenticado on public.emails_destinatarios
  for select to authenticated using (true);
create policy emails_dest_insert_autenticado on public.emails_destinatarios
  for insert to authenticated with check (true);
create policy emails_dest_delete_autenticado on public.emails_destinatarios
  for delete to authenticated using (true);
