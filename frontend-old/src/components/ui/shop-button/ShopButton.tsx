import './ShopButton.scss';
import React, { type ReactNode } from 'react';


interface ShopButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  children: ReactNode;
  left?: ReactNode;
  right?: ReactNode;
  variant?: 'primary' | 'secondary';
}

const ShopButton = ({disabled, onClick, children, left, right, variant = 'secondary'}: ShopButtonProps) => {
  return (
    <button disabled={ disabled }
            className={
              `shop-button ${ variant }` }
            onClick={ onClick }
    >
      <div className={ 'grid grid-cols-[1fr_auto_1fr] items-center'/*w-full for pushing left and right to the side*/ }>
        <div className={ 'justify-self-start max-w-6 truncate' }>
          { left }
        </div>

        <div className={ 'justify-self-center mx-4' }>
          { children }
        </div>

        <div className={ 'justify-self-end max-w-6 truncate' }>
          { right }
        </div>
      </div>
    </button>
  );
};

export default ShopButton;
