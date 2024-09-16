describe('Add to Cart', () => {
  it('should visit root', () => {
    cy.visit('/')
  })

  it('There is products on the page', () => {
    cy.visit('/')

    cy.get(".products article")
      .should('be.visible')
  })

  it('should add product to cart', () => {
    cy.visit('/')

    cy.get(".products article")
      .first()
      .contains("Add")
      .click()

    cy.get(".end-0")
      .should("contain.text", "My Cart (1)")
  })

})