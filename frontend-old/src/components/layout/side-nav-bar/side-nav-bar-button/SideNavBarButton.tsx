import React from 'react';
import './SideNavBarButton.scss';

interface SideNavBarButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  badgeCount?: number;
}

const SideNavBarButton = ({badgeCount, children, onClick, disabled}: SideNavBarButtonProps) => {
  return (
    <button disabled={ disabled } className={ 'side-nav-bar-button' } onClick={ onClick }>
      <div className={ 'content' }>
        <div className={ 'label' }>{ children }</div>
        {
          badgeCount !== undefined && <div className={ 'badge' }>{ badgeCount }</div>
        }
      </div>
    </button>
  );
};
export default SideNavBarButton;