# Cuentas de Modesta

Web para que Adrián, Carlos José y María Alejandra lleven los ingresos, gastos, casas, bancos y tarjetas de su mamá.
Un solo archivo (`index.html`), sin build. Supabase como base, Vercel para publicarla.

## Cómo se pone en marcha (una sola vez)

1. **Supabase** → proyecto nuevo → *SQL Editor* → pegar `supabase.sql` entero → *Run*.
2. **Supabase** → *Settings → API* → copiar *Project URL* y la *anon / publishable key* en `config.js`.
3. **Supabase** → *Authentication → Users → Add user → Create new user*, con *Auto Confirm User* tildado:
   - `carlos@cuentas-modesta.app`
   - `alejandra@cuentas-modesta.app`
   - `adrian@cuentas-modesta.app`

   La contraseña la elige quien crea el usuario. En la pantalla de entrada se escribe solo `carlos`, `alejandra` o `adrian`.
4. **Supabase** → *Authentication → Sign In / Providers → Email*: apagar *Allow new users to sign up*, así nadie más puede crearse una cuenta.
5. **Vercel** → *Add New → Project* → importar este repositorio → *Deploy*. Sin configuración: es una página estática.

## Datos

Una tabla, `docs(coleccion, id, data)`, con las colecciones `movimientos`, `cuentas`, `compromisos`, `propiedades` y `resumenes`.
Solo los usuarios que entraron con contraseña pueden leer o escribir (reglas en `supabase.sql`).
