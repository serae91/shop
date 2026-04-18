import React, { type ReactNode } from 'react';
import './StandardTable.scss';

const users = [
  {
    name: 'Natali Craig',
    email: 'natali@untitledui.com',
    dateAdded: 'Feb 22, 2025',
    lastActive: 'Mar 14, 2025',
  },
  {
    name: 'Drew Cano',
    email: 'drew@untitledui.com',
    dateAdded: 'Feb 22, 2025',
    lastActive: 'Mar 12, 2025',
  },
  {
    name: 'Orlando Diggs',
    email: 'orlando@untitledui.com',
    dateAdded: 'Feb 22, 2025',
    lastActive: 'Mar 12, 2025',
  },
  {
    name: 'Andi Lane',
    email: 'andi@untitledui.com',
    dateAdded: 'Feb 22, 2025',
    lastActive: 'Mar 14, 2025',
  },
  {
    name: 'Kate Morrison',
    email: 'kate@untitledui.com',
    dateAdded: 'Feb 22, 2025',
    lastActive: 'Mar 13, 2025',
  },
];

interface StandardTableProps {
  headers: string[];
  children: ReactNode;
}

const StandardTable = ({headers, children}: StandardTableProps) => {
  return (
    <div className="user-table">
      <table>
        <thead>
        <tr>
          { headers.map(header => <th key={ header }>{ header }</th>) }

          <th></th>
        </tr>
        </thead>

        <tbody>
        { children }
        </tbody>
      </table>
    </div>
  );
};

export default StandardTable;