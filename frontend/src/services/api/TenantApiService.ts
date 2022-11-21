import { TenantList } from '../../types/tenant';
import { HttpService } from './HttpService';

export class TenantApiService {
    public static readonly listTenantsPath = () => '/api/tenants';
    public static readonly deleteTenantPath = (id: number) =>
        `/api/tenants/${id}`;

    async getTenants(path: string) {
        return HttpService.get<TenantList>(path);
    }

    async deleteTenant(path: string) {
        return HttpService.delete(path);
    }
}

export const tenantApiService = new TenantApiService();
