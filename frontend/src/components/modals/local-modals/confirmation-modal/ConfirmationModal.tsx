import React, { useState } from 'react';
import './ConfirmationModal.scss';
import { useModal } from '../../../../providers/modal/ModalProvider.tsx';
import { ConfirmationDangerEnum } from '../../../../enums/ConfirmationDangerEnum.ts';

interface ConfirmationModalProps {
  title: string;
  description: string;
  confirmationButtonText: string;
  matchText?: string | undefined;
  onCancel?: (() => void) | undefined;
  onConfirm: () => Promise<any>;
  danger: ConfirmationDangerEnum;
}

const ConfirmationModal = ({
                             title,
                             description,
                             matchText,
                             confirmationButtonText,
                             onCancel,
                             onConfirm,
                             danger
                           }: ConfirmationModalProps) => {
  const [inputText, setInputText] = useState('');
  const [checkCount, setCheckCount] = useState(0);
  const {closeLocalModal} = useModal();

  const requiredCheckCount = getRequiredCheckCount(danger, matchText);
  const canConfirm = getCanConfirm(inputText, checkCount, requiredCheckCount, matchText);

  return (

    <div className="confirmation-modal-overlay">
      <div className="modal-card">
        <button className="close-btn" onClick={ closeLocalModal }>
          ×
        </button>

        <div className="icon-wrapper">
          <div className="icon-circle">
            🗑️
          </div>
        </div>

        <h2>{ title }</h2>

        <p className="description">
          { description }
        </p>

        { matchText &&
            <>
                <div className="confirmation-text">
                    <p>To confirm, type <strong>{ matchText }</strong> below</p>
                  { requiredCheckCount > 1 && <p>{ `${ checkCount + 1 } / ${ requiredCheckCount }` }</p> }
                </div>

                <input
                    type="text"
                    placeholder={ matchText }
                    value={ inputText }
                    onChange={ (e) => setInputText(e.target.value) }
                />
            </>
        }

        <div className="actions">
          <button className="btn cancel" onClick={ () => {
            onCancel?.();
            closeLocalModal();
          } }>
            Cancel
          </button>

          <button
            disabled={ matchText ? inputText !== matchText : false }
            className={ `btn ${ getConfirmButtonClassName(danger, checkCount, requiredCheckCount) }` }
            onClick={ () => {
              if (!canConfirm) {
                setCheckCount(prevState => prevState + 1);
                setInputText('');
                return;
              }
              onConfirm().then(closeLocalModal);
            } }
          >
            { confirmationButtonText }
          </button>
        </div>
      </div>
    </div>
  );
};

const getRequiredCheckCount = (danger: ConfirmationDangerEnum, matchText?: string) => {
  if (!matchText) return 0;
  return danger === ConfirmationDangerEnum.DOUBLE_CHECK ? 2 : 1;
};

const getCanConfirm = (inputText: string, checkCount: number, requiredCheckCount: number, matchText?: string) => {
  if (!matchText) return true;
  if (checkCount < requiredCheckCount - 1) return false;
  return inputText === matchText;
};

const getConfirmButtonClassName = (danger: ConfirmationDangerEnum, checkCount: number, requiredCheckCount: number) => {
  switch (danger) {
    case ConfirmationDangerEnum.NONE:
      return 'normal';
    case ConfirmationDangerEnum.DANGER:
      return 'danger';
    case ConfirmationDangerEnum.DOUBLE_CHECK:
      return checkCount < requiredCheckCount - 1 ? 'low-danger' : 'high-danger';
  }
};

export default ConfirmationModal;