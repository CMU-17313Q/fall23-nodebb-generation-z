import { Box, Center, Checkbox, Flex, Spinner, Stack, Text } from '@chakra-ui/react';
import { IconArrowBack } from '@tabler/icons';
import { useCallback, useMemo } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import useSWR from 'swr';
import Breadcrumbs from '../components/Navigation/Breadcrumbs';
import PageContainer from '../components/PageContainer';
import { useNotification } from '../hooks/useNotification';
import { rentApiService, RentApiService } from '../services/api/RentApiService';
import { tenantApiService, TenantApiService } from '../services/api/TenantApiService';
import { Rent, RentList } from '../types/rent';
import { TenantResponse } from '../types/tenant';

function Tenant() {
    const { id } = useParams();
    const navigate = useNavigate();
    const { showError, showSuccess } = useNotification();

    const { data: tenantData, error: tenantError, isValidating: isValidatingTenant } = useSWR<TenantResponse>(
        TenantApiService.getTenantPath(Number(id)),
        tenantApiService.getTenant
    );

    const isLoadingTenant = useMemo(() => tenantData === undefined || (isValidatingTenant && tenantError !== undefined), [tenantData, isValidatingTenant, tenantError]);
    const isTenantError = useMemo(() => tenantError !== undefined, [tenantError]);
    const tenant = useMemo(() => tenantData?.tenant, [tenantData]);

    const { data: rentData, error: rentError, isValidating: isValidatingRent, mutate: mutateRents } = useSWR<RentList>(
        tenant ? RentApiService.getRentsByTenantIdPath(tenant.id) : null,
        rentApiService.getRents
    );

    const isLoadingRents = useMemo(() => rentData === undefined || (isValidatingRent && rentError !== undefined), [rentData, isValidatingRent, rentError]);
    const isRentError = useMemo(() => rentError !== undefined, [rentError]);
    const rents = useMemo(() => rentData?.rents, [rentData]);

    const breadcrumbs = useMemo(
        () => [
            {
                label: 'Tenants',
                href: '/tenants',
            },
            {
                label: tenant?.name,
                href: `/tenants/${tenant?.id}`,
            },
        ],
        [tenant],
    );

    const onRentStatusUpdate = useCallback(async (rent: Rent) => {
        try {
            await rentApiService.updateRent(RentApiService.markRentPath(rent.id, !rent.paid));
            showSuccess('Rent status updated', 'Successfully updated the status of the rent');
        }
        catch {
            showError('Error', 'An error occured while trying to update the rent status.');
        }
        finally {
            mutateRents();
        }
    }, []);

    return (
        <Box>
            <Breadcrumbs items={breadcrumbs} />
            <PageContainer>
                {isLoadingTenant && (
                    <Center>
                        <Spinner size="lg" />
                    </Center>
                )}
                {!isLoadingTenant && !isTenantError && tenant && (
                    <Stack spacing={1}>
                        <Flex gap={2} alignItems="center">
                            <IconArrowBack
                                size={24}
                                cursor="pointer"
                                onClick={() => navigate('/tenants')}
                            />
                            <Text fontSize="2xl" fontWeight="bold">
                                {tenant.name}
                            </Text>
                        </Flex>
                        {isLoadingRents && (
                            <Center>
                                <Spinner size="lg" />
                            </Center>
                        )}
                        {!isLoadingRents && !isRentError && rents && (
                            <Stack spacing={1}>
                                <Text fontSize="xl">Rents:</Text>
                                {
                                    rents.map(rent => {
                                        return <Flex key={rent.due_date} gap={2} alignItems="center">
                                            <Text>{new Date(rent.due_date).toDateString()}</Text>
                                            <Checkbox checked={rent.paid} onChange={() => onRentStatusUpdate(rent)} />
                                        </Flex>;
                                    })
                                }
                            </Stack>
                        )}
                    </Stack>
                )}
            </PageContainer>
        </Box>
    );
};

export default Tenant;