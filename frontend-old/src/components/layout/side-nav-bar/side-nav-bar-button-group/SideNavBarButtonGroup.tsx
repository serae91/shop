import React, { type ReactNode } from 'react';
import './SideNavBarButtonGroup.scss';

interface SideNavBarButtonGroupProps {
  title?: string;
  children: ReactNode;
}

const SideNavBarButtonGroup = ({title, children}: SideNavBarButtonGroupProps) => {
  return (
    <div className={ 'side-nav-bar-button-group' }>
      { title && <div className={ 'title' }>{ title }</div> }
      { children }
    </div>
  );
};
export default SideNavBarButtonGroup;