# Generate & Manage Code Documents with Knowl AI & Rich Text Editor
This GitHub Action allows you to generate and auto-update code documentation for your entire repository using Knowl AI. By utilizing high-quality and trusted documents, you can increase your team's productivity and support your code effectively.

Currently, the following languages are supported: JavaScript, Typescript, Node.js, Python, and Java, with more languages on the way.

## How to Generate Docs
Follow the steps below to generate code documentation:
- Add the `KNOWL_API_KEY` in your repository variables. Generate Knowl API Key from your profile section in the [Knowl](https://app.knowl.io).
- Add the `OPENAI_API_KEY` in your repository variables.
- Run the action manually for the first time. Please note that generating documents for the first time, especially for large repositories, might take a while.
- Code documents will be automatically updated with every merge.

YAML for the Action
```yaml
name: Generate Code Documents
run-name: Generate Code Documents
on: [workflow_dispatch]

jobs:
  gen-ai-doc:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0
      - name: Generate AI docs
        uses: knowl-doc/code-to-doc-manual@main
        env:
          KNOWL_API_KEY: ${{secrets.KNOWL_API_KEY}}
          OPENAI_API_KEY: ${{secrets.OPENAI_API_KEY}}
          OPENAI_BATCH_SIZE: 25
      - name: Upload artifact
        uses: actions/upload-artifact@v2
        with:
          name: knowl_results
          path: knowl_results
```
## Enjoy Code Documents in Your Code Editor
With this GitHub Action, your team can benefit from well-crafted code documents without spending additional time writing them. Here are the advantages:

- Access information in VS Code using this [official plugin](https://marketplace.visualstudio.com/items?itemName=knowl.knowl)
- Enjoy consistent, complete, and continuously updated documents
- Add additional information as needed in the AI-powered Rich Text Editor. Knowl's CLI integration keeps this information also updated.

## Access Documents in VS Code Editor

- Install [Knowl's Official VS Code Plugin](https://marketplace.visualstudio.com/items?itemName=knowl.knowl)
- Configure the extension settings:
  - Knowl API Key: Generate and copy the Knowl API Key from your profile section in the [Knowl](https://app.knowl.io).
  - Base Git Branch:  Input the name of your base git branch (e.g., 'master' or 'main') based on your repository setup.

**Example** 

Here's an example to view the document for an open-source project in VS Code:
- Install VS Code Plugin
- Configure the extension settings:
  - Knowl API Key - `4wUXXmv6.QXviMhzcfmOy56rW3NgWu3sT4DyE7R2v`
  - Base Git Branch - `main`
- To view documents for TypeScript, JavaScript, and Node.js:
  - Clone the [Knowl's Fork](https://github.com/knowl-doc/mermaid) of the open-source project **mermaid**
  -  Open the `mermaid` folder in VS code
  -  Open any file (e.g., mermaid.ts).
  -  Click the Knowl icon next to any function
- To view documents for Java:
  - Clone the [Knowl's Fork](https://github.com/knowl-doc/Calculator-1) of the open-source project **Calculator**
  - Open the `Calculator` folder in VS code
  - Open any file
  - Click the Knowl icon next to any function
- Log in to the Knowl page to see the documentation:
  - email - demo@example.com
  - password - abc123$%

<img src="https://releases.knowl.io/github-action/vs-code-knowl-open.jpg" width="700">

## Access Documents in Knowl Editor
To access the code documents in the Knowl Editor, follow these steps:

- Login to the [Knowl](https://app.knowl.io). Contact support@knowl.io if you need any assistance.
- Navigate to your repository folder. The folder structure mirrors your code repository.
- View documents linked to functions with function, file, folder, and repository-level summaries.

**Example** 

Here's an example to view the document for an open-source project in the Knowl Editor:

- See the [documentation for mermaid](https://app.knowl.io/k/af8800c3-8ed7-4c10-af62-6e33a054f36d) in Knowl
  - This is the documentation for Javascript
  - mermaid.js is an open-source project. Link to [Knowl's Fork](https://github.com/knowl-doc/mermaid)
- See the [documentation for Calculator](https://app.knowl.io/k/2e7f3bd2-54e7-4cc2-ab11-05534d6165bd) in Knowl
  - This is the documentation for Java
  - Calculator is an open-source project. Link to [Knowl's Fork](https://github.com/knowl-doc/Calculator-1)
-  Log in to the Knowl page to see the documentation for open source projects:
    - email - demo@example.com
    - password - abc123$%

_screenshot for code-doc snippet linked to a function_

<img src="https://releases.knowl.io/github-action/code-doc.jpg" width="700">
