import './StandardTitle.scss';
import { Fragment, type ReactNode } from 'react';

interface StandardTitleProps {
  title?: string;
  subtitle?: string;
  right?: ReactNode;
  pathRoutes?: string[];
}

const StandardTitle = ({title, subtitle, right, pathRoutes}: StandardTitleProps) => {

  const displayPathRoutes = () => {
    if (!pathRoutes?.length) return;
    return (<div className="text-sm font-medium text-gray-400 mb-6"> { pathRoutes.map((route, index) => (
      <Fragment key={ route }>{ !!index && <span className="mx-2">/</span> }{ route }</Fragment>
    )) }</div>);
  };

  return (
    <div className={ 'standard-title' }>
      <div className={ 'flex-col' }>
        { displayPathRoutes() }
        { title && <h2 className={ 'title' }>
          { title }
        </h2> }
        { subtitle && <p className={ 'sub-title' }>
          { subtitle }
        </p> }
      </div>
      <div className={ 'right' }>
        { right && right }
      </div>
    </div>
  );
};

export default StandardTitle;