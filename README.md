<p align="center">
  <img src="assets/images/logo.png" alt="Interlal Logo" width="150"/>
</p>

<h1 align="center">Interlal</h1>

O Interlal é um aplicativo Flutter desenvolvido para acompanhar os jogos interclasse da escola ETE Luiz Alves Lacerda. Com ele, usuários podem:

*   Visualizar os próximos jogos e resultados recentes.
*   Monitorar um placar em tempo real.
*   Acompanhar o ranking de times e jogadores.

## Configuração

1.  **Instale as dependências:**

    ```bash
    flutter pub get
    ```

2.  **Configure o Supabase:**

    *   Crie um projeto no [Supabase](https://supabase.com/).
    *   Defina as variáveis de ambiente `SUPABASE_URL` e `SUPABASE_ANON_KEY` no arquivo `.env` na raiz do projeto.

    ```
    SUPABASE_URL=YOUR_SUPABASE_URL
    SUPABASE_ANON_KEY=YOUR_SUPABASE_ANON_KEY
    ```

3.  **Execute o aplicativo:**

    ```bash
    flutter run
    ```

## Contribuição

Contribuições são sempre bem-vindas! Sinta-se à vontade para abrir issues ou enviar pull requests.

## Licença

[MIT](LICENSE)
