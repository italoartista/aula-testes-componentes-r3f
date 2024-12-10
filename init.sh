#!/bin/bash

# Abort on error
set -e

echo "🚀 Configurando o ambiente para React Three Fiber com Cypress no projeto Vite..."

# 1. Criar as pastas para os componentes e testes
echo "📁 Criando estrutura de pastas..."
mkdir -p src/components/RotatingCube
mkdir -p src/components/InteractiveCube
mkdir -p cypress/integration/components

# 2. Criar o arquivo de componente RotatingCube
echo "🛠️ Criando componente RotatingCube..."
cat > src/components/RotatingCube/RotatingCube.jsx <<EOL
import React from "react";
import { useFrame } from "@react-three/fiber";

export function RotatingCube({ color = "blue" }) {
  const ref = React.useRef();

  useFrame(() => {
    if (ref.current) {
      ref.current.rotation.x += 0.01;
      ref.current.rotation.y += 0.01;
    }
  });

  return (
    <mesh ref={ref}>
      <boxGeometry args={[1, 1, 1]} />
      <meshStandardMaterial color={color} />
    </mesh>
  );
}
EOL

# 3. Criar o arquivo de componente InteractiveCube
echo "🛠️ Criando componente InteractiveCube..."
cat > src/components/InteractiveCube/InteractiveCube.jsx <<EOL
import React, { useState } from "react";

export function InteractiveCube() {
  const [color, setColor] = useState("blue");

  return (
    <mesh
      onClick={() => setColor(color === "blue" ? "red" : "blue")}
      position={[0, 0, 0]}
    >
      <boxGeometry args={[1, 1, 1]} />
      <meshStandardMaterial color={color} />
    </mesh>
  );
}
EOL

# 4. Criar testes Cypress para os componentes
echo "✅ Criando testes Cypress..."
cat > cypress/integration/components/rotatingCube.spec.js <<EOL
describe("RotatingCube Component", () => {
  it("renders the cube with default color", () => {
    cy.mount(<RotatingCube />);
    cy.get("mesh").should("exist");
  });

  it("renders the cube with a custom color", () => {
    cy.mount(<RotatingCube color="red" />);
    cy.get("mesh").should("have.attr", "material", "red");
  });
});
EOL

cat > cypress/integration/components/interactiveCube.spec.js <<EOL
describe("InteractiveCube Component", () => {
  it("changes color on click", () => {
    cy.mount(<InteractiveCube />);
    cy.get("mesh").click();
    cy.get("mesh").should("have.attr", "material", "red");
  });
});
EOL

# 5. Instalar dependências necessárias
echo "📦 Instalando dependências..."
npm install @react-three/fiber three
npm install --save-dev cypress @cypress/react @cypress/vite-dev-server

# 6. Configurar Cypress com React
echo "⚙️ Configurando Cypress com React..."
cat > cypress/support/component.js <<EOL
import React from "react";
import { mount } from "cypress/react";
import { Canvas } from "@react-three/fiber";

Cypress.Commands.add("mount", (component) => {
  const wrapped = <Canvas>{component}</Canvas>;
  mount(wrapped);
});
EOL

cat > cypress.config.js <<EOL
const { defineConfig } = require("cypress");

module.exports = defineConfig({
  component: {
    devServer: {
      framework: "react",
      bundler: "vite",
    },
    specPattern: "cypress/integration/components/**/*.spec.js",
  },
});
EOL

# Finalização
echo "🎉 Configuração concluída com sucesso! Agora você pode executar os testes com Cypress."
echo "👉 Comandos úteis:"
echo "   - Iniciar Cypress: npx cypress open"
echo "   - Rodar testes: npx cypress run"

