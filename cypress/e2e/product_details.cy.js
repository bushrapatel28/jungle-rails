describe('Home Page', () => {
  it('should visit root', () => {
    cy.visit('/')
  })

  it('There is products on the page', () => {
    cy.visit('/')

    cy.get(".products article")
      .should('be.visible')
  })

  it('should navigate to product detail page', () => {
    cy.visit('/')

    cy.get(".products article")
      .first()
      .click()

    cy.get(".products-show article")
      .should('be.visible')
  })

})