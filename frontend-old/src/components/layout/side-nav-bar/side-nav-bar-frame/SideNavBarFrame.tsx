import './SideNavBarFrame.scss';
import type { ReactNode } from 'react';

interface SideNavBarFrameProps {
  children: ReactNode;
}

const SideNavBarFrame = ({children}: SideNavBarFrameProps) => {
  return (<aside className={ 'side-nav-bar-frame' }>{ children }</aside>);
};

export default SideNavBarFrame;