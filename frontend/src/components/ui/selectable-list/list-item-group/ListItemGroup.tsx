import ListSubheader from '@mui/material/ListSubheader';
import React, { type ReactNode } from 'react';
import ShopListItem, { type ListItemProps } from '../list-item/ShopListItem.tsx';
import { Divider } from '@mui/material';
import './ListItemGroup.scss';
import type { Selectable } from '../../../../providers/multi-select/MultiSelectProvider.tsx';

export interface ListItemGroupProps<T extends Selectable> {
  id: number;
  selected: Selectable[];
  toggle: (selectable: ListItemProps<T>) => void;
  listSubheader: ReactNode;
  listItems: ListItemProps<T>[];
}

const ListItemGroup = <T extends Selectable>({
                                               id,
                                               selected,
                                               toggle,
                                               listSubheader,
                                               listItems
                                             }: ListItemGroupProps<T>) => {

  return (
    <div className={ 'list-item-group' }>
      <Divider/>
      <ListSubheader>{ listSubheader }</ListSubheader>
      <div className={ 'items' }>{
        listItems.map((item) =>
          <ShopListItem
            key={ item.id }
            id={ item.id }
            primary={ item.primary }
            secondary={ item.secondary ?? '' }
            start={ item.start ?? '' }
            selected={ selected.includes(item) }
            originalObject={ item.originalObject }
            end={ item.end ?? (() => undefined) }
            onClick={ () => {
              toggle(item);
              if (item.onClick) {
                item.onClick();
              }
            } }/>
        )
      }</div>
    </div>
  );
};

export default ListItemGroup;
