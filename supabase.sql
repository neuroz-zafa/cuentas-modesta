-- Cuentas de Modesta: pegar entero en Supabase → SQL Editor → Run.
-- Una sola tabla con todas las colecciones de la app (movimientos, cuentas, compromisos, propiedades, resumenes).
create table if not exists public.docs (
  coleccion   text not null,
  id          text not null,
  data        jsonb not null default '{}'::jsonb,
  actualizado timestamptz not null default now(),
  autor       uuid default auth.uid(),
  primary key (coleccion, id)
);

-- Solo los usuarios que entraron con su contraseña ven y cargan datos. Sin usuario, nada.
alter table public.docs enable row level security;
drop policy if exists "familia lee" on public.docs;
drop policy if exists "familia carga" on public.docs;
drop policy if exists "familia corrige" on public.docs;
drop policy if exists "familia borra" on public.docs;
create policy "familia lee"     on public.docs for select to authenticated using (true);
create policy "familia carga"   on public.docs for insert to authenticated with check (true);
create policy "familia corrige" on public.docs for update to authenticated using (true) with check (true);
create policy "familia borra"   on public.docs for delete to authenticated using (true);

-- Lo que carga un hermano les aparece a los otros al instante.
alter table public.docs replica identity full;
do $$ begin
  alter publication supabase_realtime add table public.docs;
exception when duplicate_object then null; end $$;

-- Las dos casas que ya estaban cargadas.
insert into public.docs (coleccion, id, data) values
  ('propiedades','aristobulo','{"nombre":"Depto. Aristóbulo del Valle","direccion":"Aristóbulo del Valle 2750, 5° A","partida":"","uso":"Alquilado","orden":1}'),
  ('propiedades','veinte-septiembre','{"nombre":"20 de Septiembre 283","direccion":"20 de Septiembre 283","partida":"","uso":"En venta","orden":2}')
on conflict (coleccion, id) do nothing;
