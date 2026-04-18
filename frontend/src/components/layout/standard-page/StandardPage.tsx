import './StandardPage.scss';
import StandardContentCard from './standard-content-card/StandardContentCard.tsx';
import type { ReactNode } from 'react';
import StandardTitle from './standard-title/StandardTitle.tsx';
import LocalModalRenderer from '../../modals/local-modals/local-modal-renderer/LocalModalRenderer.tsx';

interface StandardPageProps {
  title?: string;
  subtitle?: string;
  pathRoutes?: string[];
  titleRight?: ReactNode;
  children: ReactNode;
}

const StandardPage = ({title, subtitle, pathRoutes, titleRight, children}: StandardPageProps) => {

  return (
    <StandardContentCard className={ 'standard-page' }>
      <LocalModalRenderer/>
      <StandardTitle title={ title ?? '' } subtitle={ subtitle ?? '' } pathRoutes={ pathRoutes ?? [] }
                     right={ titleRight }/>
      <div className={ 'page-content' }>{ children }</div>
    </StandardContentCard>

  );
};

export default StandardPage;