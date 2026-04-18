import type { ReactNode } from 'react';

interface ListCardContentFrameProps {
  children: ReactNode;
}

const ListCardContentFrame = ({children}: ListCardContentFrameProps) => {
  return (
    <div className={ 'flex-1 px-8 py-6 flex flex-col h-full' }>
      <div className={ 'flex flex-col gap-6 max-w-4xl h-full' }>
        { children }
      </div>
    </div>
  );
};

export default ListCardContentFrame;