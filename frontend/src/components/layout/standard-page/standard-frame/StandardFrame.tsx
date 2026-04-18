import './StandardFrame.scss';
import type { ReactNode } from 'react';

interface StandardFrameProps {
  children: ReactNode,
  className?: string;
}

const StandardFrame = ({children, className}: StandardFrameProps) => {
  return (
    <div className={ `standard-frame ${ className ?? '' }` }>
      { children }
    </div>
  );
};

export default StandardFrame;