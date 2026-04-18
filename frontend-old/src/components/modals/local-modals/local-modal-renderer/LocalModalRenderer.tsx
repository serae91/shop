import { useModal } from '../../../../providers/modal/ModalProvider.tsx';
import { LocalModalTypeEnum } from '../../../../enums/LocalModalTypeEnum.ts';
import CreateChatModal from '../create-chat-modal/CreateChatModal.tsx';
import ChatModal from '../chat-modal/ChatModal.tsx';
import AddGroupMembersModal from '../add-group-members-modal/AddGroupMembersModal.tsx';
import CreateGroupModal from '../create-group-modal/CreateGroupModal.tsx';
import ConfirmationModal from '../confirmation-modal/ConfirmationModal.tsx';


const LocalModalRenderer = () => {
  const {localModalState} = useModal();

  const topModalState = localModalState.at(-1);

  switch (topModalState?.type) {
    case LocalModalTypeEnum.JOIN_CHAT:
      return <ChatModal/>;
    case LocalModalTypeEnum.CREATE_CHAT:
      return <CreateChatModal initialValues={ topModalState.initialValues }/>;
    case LocalModalTypeEnum.CREATE_GROUP:
      return <CreateGroupModal/>;
    case LocalModalTypeEnum.ADD_GROUP_MEMBERS:
      return <AddGroupMembersModal initialValues={ topModalState.initialValues }/>;
    case LocalModalTypeEnum.CONFIRMATION:
      return <ConfirmationModal
        title={ topModalState.title }
        description={ topModalState.description }
        confirmationButtonText={ topModalState.confirmationButtonText }
        matchText={ topModalState.matchText }
        onCancel={ topModalState?.onCancel }
        onConfirm={ topModalState.onConfirm }
        danger={ topModalState.danger }/>;
    default:
      return null;
  }
};

export default LocalModalRenderer;
