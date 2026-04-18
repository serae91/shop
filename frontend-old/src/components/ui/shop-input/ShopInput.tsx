import './ShopInput.scss';
import type { InputHTMLAttributes, ReactNode, RefObject } from 'react';

interface ShopInputProps extends InputHTMLAttributes<HTMLInputElement> {
  className?: string;
  inputRef?: RefObject<HTMLInputElement | null>;
  icon?: ReactNode;
}

const ShopInput = ({inputRef, icon, className = '', ...props}: ShopInputProps) => {
  return (
    <div className={ 'relative flex items-center w-full' }>
      { icon &&
          <div className={ 'absolute left-3 text-gray-500 pointer-events-none flex items-center justify-center' }>
            { icon }
          </div>
      }
      <input
        ref={ inputRef }
        className={ `w-full rounded-lg border border-gray-300 bg-white px-3 py-2.5 text-gray-900 shadow-xs placeholder:text-gray-500 focus:border-brand-500 focus:outline-none focus:ring-1 focus:ring-brand-500 sm:text-sm ${ icon ? 'pl-10' : '' } ${ className }` }
        { ...props } />

    </div>
  );
};

export default ShopInput;
