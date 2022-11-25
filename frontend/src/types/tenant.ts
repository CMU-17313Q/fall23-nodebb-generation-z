import { Rent } from './rent';

export interface Tenant {
    id: number;
    name: string;
    email?: string;
    phone?: string;
    unpaid_rents: Rent[];
}

export interface TenantList {
    tenants: Tenant[];
}

export interface TenantDto {
    tenant: Omit<Tenant, 'id' | 'name'> & {
        first_name: string;
        last_name: string;
    };
}

export interface TenantUpdateDto extends TenantDto {
    id: number;
}