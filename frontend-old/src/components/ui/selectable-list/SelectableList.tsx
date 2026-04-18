import List from '@mui/material/List';
import ListItemGroup, { type ListItemGroupProps } from './list-item-group/ListItemGroup.tsx';
import ShopListItem, { type ListItemProps } from './list-item/ShopListItem.tsx';
import './SelectableList.scss';
import type { Dispatch, SetStateAction } from 'react';
import type { Selectable } from '../../../providers/multi-select/MultiSelectProvider.tsx';

interface SelectableListProps<T extends Selectable> {
  singleItems?: ListItemProps<T>[];
  groups?: ListItemGroupProps<T>[];
  selected: Selectable[];
  setSelected: Dispatch<SetStateAction<Selectable[]>>;
}

const SelectableList = <T extends Selectable>({
                                                selected,
                                                setSelected,
                                                singleItems,
                                                groups
                                              }: SelectableListProps<T>) => {

  const toggle = (item: ListItemProps<T>) => {
    setSelected((prev) => {
        const ids = prev.map(value => value.id);
        return ids.includes(item.id)
          ? prev.filter((value) => value.id !== item.id)
          : [...prev, item.originalObject];
      }
    );
  };

  return (
    <div onMouseDown={ (e) => e.preventDefault() }>
      <List>
        {
          singleItems?.map(item =>
            <ShopListItem
              key={ item.id }
              id={ item.id }
              primary={ item.primary }
              secondary={ item.secondary }
              start={ item.start }
              end={ item.end ?? (() => undefined) }
              selected={ selected.map(s => s.id).includes(item.id) }
              originalObject={ item.originalObject }
              onClick={ () => {
                toggle(item);
                item.onClick?.();
              } }
            />)
        }
        {
          groups?.map(group =>
            <ListItemGroup
              selected={ selected }
              toggle={ toggle }
              key={ group.id }
              id={ group.id }
              listSubheader={ group.listSubheader }
              listItems={ group.listItems }
            />)
        }
      </List>
    </div>
  );
};

export default SelectableList;
