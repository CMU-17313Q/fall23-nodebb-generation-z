import { Preference } from '../types/preferences';

export function getPreferenceValueByName(
    preferences: Preference[],
    name: string,
    defaultValue = '',
): string {
    return (
        preferences.find((preference) => preference.name === name)?.value ??
        defaultValue
    );
}
