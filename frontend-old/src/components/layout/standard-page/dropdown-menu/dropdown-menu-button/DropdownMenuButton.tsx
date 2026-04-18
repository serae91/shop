import './DropdownMenuButton.scss';
import { type ReactNode } from 'react';

interface DropdownMenuButtonProps {
  children: ReactNode;
  onClick: () => void;
  disabled?: boolean;
  variant?: 'danger' | 'normal';
}

const DropdownMenuButton = ({children, onClick, disabled = false, variant = 'normal'}: DropdownMenuButtonProps) => {
  return (
    <div className={ 'dropdown-menu-button' }>
      <button onClick={ onClick } className={ variant } disabled={ disabled }>
        { children }
      </button>
    </div>
  );
};

export default DropdownMenuButton;