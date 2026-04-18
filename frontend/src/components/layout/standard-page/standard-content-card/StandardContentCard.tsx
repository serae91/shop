import './StandardContentCard.scss';
import type { ReactNode } from 'react';


interface StandardContentCardProps {
  children: ReactNode,
  className?: string;
}

const StandardContentCard = ({children, className}: StandardContentCardProps) => {
  return (
    <div className={ `standard-content-card ${ className ?? '' }` }>
      { children }
    </div>
  );
};

export default StandardContentCard;
