import { useModal } from '../../../providers/modal/ModalProvider.tsx';
import React from 'react';
import SideNavBarFrame from './side-nav-bar-frame/SideNavBarFrame.tsx';
import SideNavBarButtonGroup from './side-nav-bar-button-group/SideNavBarButtonGroup.tsx';

const SideNavBar = () => {
  const {openLocalModal} = useModal();

  return (
    <SideNavBarFrame>
      <SideNavBarButtonGroup>
        Hi
      </SideNavBarButtonGroup>
      <SideNavBarButtonGroup title={ 'Groups' }>
        Bye
      </SideNavBarButtonGroup>
    </SideNavBarFrame>


  );
};

export default SideNavBar;