import './ShopButtonGroup.scss';

export type ButtonItem = {
  label: string;
  value: string;
};

type ShopButtonGroupProps = {
  buttons: ButtonItem[];
  active: string;
  onChange: (value: string) => void;
};

const ShopButtonGroup = ({buttons, active, onChange}: ShopButtonGroupProps) => {
  return (
    <div className={ 'shop-button-group' }>
      { buttons.map((btn) => (
        <button
          key={ btn.value }
          className={ `button-group__btn ${
            active === btn.value ? 'button-group__btn--active' : ''
          }` }
          onClick={ () => onChange(btn.value) }
        >
          { btn.label }
        </button>
      )) }
    </div>
  );
};

export default ShopButtonGroup;