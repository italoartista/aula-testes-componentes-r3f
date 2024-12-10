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
