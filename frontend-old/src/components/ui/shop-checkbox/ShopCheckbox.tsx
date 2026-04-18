import React, { type Dispatch, type SetStateAction } from 'react';
import { Checkbox } from '@mui/material';

interface ShopCheckboxProps extends React.InputHTMLAttributes<HTMLInputElement> {
  checked: boolean;
  setChecked: Dispatch<SetStateAction<boolean>>;
  label: string;
}

export const ShopCheckbox = ({checked, setChecked, label, className = ''}: ShopCheckboxProps) => {
  return (
    <label
      className={ `relative flex gap-3 cursor-pointer group ${ className }` }>
      <div className={ 'relative flex items-center justify-center mt-0.5' }>
        <Checkbox
          sx={ {
            color: '#000',
            '&.Mui-checked': {
              color: '#7F56D9',
            },
          } } checked={ checked }
          onChange={ (event) => setChecked(event.target.checked) }
        />
        <span className={ 'text-sm font-medium text-gray-700 select-none' }>
        { label }
      </span>
      </div>
    </label>);

};

export default ShopCheckbox;