describe("InteractiveCube Component", () => {
  it("changes color on click", () => {
    cy.mount(<InteractiveCube />);
    cy.get("mesh").click();
    cy.get("mesh").should("have.attr", "material", "red");
  });
});
