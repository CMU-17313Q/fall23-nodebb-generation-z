import {  TenantDto, TenantList, TenantResponse } from '../../types/tenant';
import { HttpService } from './HttpService';

export class TenantApiService extends HttpService {
    public static readonly listTenantsPath = () => '/api/tenants';
    public static readonly addTenantPath = () => '/api/tenants';
    public static readonly getTenantPath = (id: number) => `/api/tenants/${id}`;
    public static readonly updateTenantPath = (id: number) => `/api/tenants/${id}`; 
    public static readonly deleteTenantPath = (id: number) =>
        `/api/tenants/${id}`;

    async getTenants(path: string) {
        return HttpService.get<TenantList>(path);
    }

    async getTenant(path: string) {
        return HttpService.get<TenantResponse>(path);
    }

    async addTenant(path: string, tenant: TenantDto) {
        return HttpService.post<TenantDto>(path, tenant);
    }

    async updateTenant(path: string, tenant: TenantDto) {
        return HttpService.patch<TenantDto>(path, tenant);
    }

    async deleteTenant(path: string) {
        return HttpService.delete(path);
    }
}

export const tenantApiService = new TenantApiService();
