import './DropdownMenu.scss';
import { type ReactNode, useEffect, useRef } from 'react';


interface DropdownMenuProps {
  isVisible: boolean;
  onClickOutside: () => void;
  children: ReactNode;
}

const DropdownMenu = ({isVisible, onClickOutside, children}: DropdownMenuProps) => {

  const menuRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    function handleClickOutside(event: MouseEvent) {
      if (menuRef.current && !menuRef.current.contains(event.target as Node)) {
        onClickOutside();
      }
    }

    document.addEventListener('mousedown', handleClickOutside);
    return () => {
      document.removeEventListener('mousedown', handleClickOutside);
    };
  }, [onClickOutside]);

  if (!isVisible) return;

  return (
    <div ref={ menuRef } className={ 'dropdown-menu' }>
      {
        children
      }
    </div>
  );
};

export default DropdownMenu;