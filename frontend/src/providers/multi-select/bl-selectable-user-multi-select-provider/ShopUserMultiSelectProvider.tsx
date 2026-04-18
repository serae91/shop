import createMultiSelectProvider from '../MultiSelectProvider.tsx';
import type { ShopUserDto } from '../../../dtos/ShopUserDto.ts';
import { getFilteredUsers } from '../../../services/UserService.ts';
import type { ReactNode } from 'react';

const {
  MultiSelectProvider,
  useMultiSelect,
} = createMultiSelectProvider<ShopUserDto>();

interface ShopUserMultiSelectProviderProps {
  children: ReactNode;
  initialValues?: any;
}

export const useShopUserMultiSelect = useMultiSelect;

export const ShopUserMultiSelectProvider = ({children, initialValues}: ShopUserMultiSelectProviderProps) => {
  const filter = (user: ShopUserDto, query: string) => {
    const noBlankLowerCaseQuery = query.replaceAll(' ', '').toLowerCase();
    if (`${ user.firstName }${ user.lastName }`.toLowerCase().includes(noBlankLowerCaseQuery)) return true;
    if (`${ user.lastName }${ user.firstName }`.toLowerCase().includes(noBlankLowerCaseQuery)) return true;
    return user.username.toLowerCase().includes(noBlankLowerCaseQuery);
  };
  return (<MultiSelectProvider filter={ filter } fetchOptions={ getFilteredUsers }
                               initialValues={ initialValues }>{ children }</MultiSelectProvider>);
};
