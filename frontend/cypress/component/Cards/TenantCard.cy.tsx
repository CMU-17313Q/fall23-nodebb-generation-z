import TenantCard from '../../../src/components/Tenant/TenantCard';

describe('PropertyCard', () => {
    it('should render and react to events properly', () => {
        const onDeleteClick = cy.stub();
        const onEditClick = cy.stub();

        cy.mount(
            <TenantCard
                onDeleteClick={onDeleteClick}
                onEditClick={onEditClick}
                tenant={{
                    id: 1,
                    name: 'Test Tenant',
                    unpaid_rents: [],
                }}
            />,
        );

        cy.get('.chakra-text').should('have.text', 'Test Tenant');
        cy.get('.chakra-text').click();
        cy.get('.icon-tabler-pencil').click();
        cy.get('.icon-tabler-trash').click();

        cy.wrap(onDeleteClick).should('have.been.called');
        cy.wrap(onEditClick).should('have.been.called');
    });

    it('should render due rent', () => {
        const due_Date = new Date();
        const due_date = `${due_Date.getFullYear()}-${due_Date.getMonth()}-${due_Date.getDay()}`;

        cy.mount(
            <TenantCard
                onDeleteClick={() => null}
                onEditClick={() => null}
                tenant={{
                    id: 1,
                    name: 'Test Tenant',
                    unpaid_rents: [{
                        id: 1,
                        paid: false,
                        due_date,
                    }],
                }}
            />,
        );

        cy.get('.chakra-text').last().should('have.text', 'Has due rent');
    });

    it('should render overdue rent', () => {
        const due_Date = new Date();
        due_Date.setDate(due_Date.getDate() - 5);

        const due_date = `${due_Date.getFullYear()}-${due_Date.getMonth()}-${due_Date.getDay()}`;

        cy.mount(
            <TenantCard
                onDeleteClick={() => null}
                onEditClick={() => null}
                tenant={{
                    id: 1,
                    name: 'Test Tenant',
                    unpaid_rents: [{
                        id: 1,
                        paid: false,
                        due_date,
                    }],
                }}
            />,
        );

        cy.get('.chakra-text').last().should('have.text', 'Has overdue rent');
    });
});
