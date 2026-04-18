import ListItem from '@mui/material/ListItem';
import ListItemText from '@mui/material/ListItemText';
import ListItemIcon from '@mui/material/ListItemIcon';
import './ShopListItem.scss';
import React, { type ReactNode } from 'react';
import type { Selectable } from '../../../../providers/multi-select/MultiSelectProvider.tsx';

export interface ListItemProps<T extends Selectable> {
  id: number;
  primary: ReactNode;
  secondary?: ReactNode;
  start?: ReactNode;
  end?: (selected: boolean) => ReactNode;
  onClick?: () => void;
  selected: boolean;
  originalObject: T;
}

const ShopListItem = <T extends Selectable>({
                                              primary,
                                              secondary,
                                              start,
                                              end,
                                              onClick,
                                              selected = false,
                                            }: ListItemProps<T>) => {
  return (
    <div className={ `shop-list-item${ selected ? '--selected' : '' }` }>
      <ListItem onClick={ onClick }>
        { start && <ListItemIcon>{ start }</ListItemIcon> }

        <ListItemText
          primary={ primary }
          secondary={ secondary }
        />
        { end?.(selected) }
      </ListItem>
    </div>
  );
};

export default ShopListItem;
