import StandardTable from '../StandardTable.tsx';
import React from 'react';
import type { RelGroupUserSettingsView } from '../../../../../dtos/RelGroupUserSettingsView.ts';

interface UserTableProps {
  groupUserViews: RelGroupUserSettingsView[];
}

const UserTable = ({groupUserViews}: UserTableProps) => {
  return (
    <StandardTable headers={ ['Name', 'Date added', 'Last active'] }>
      { groupUserViews.map((user, index) => (
        <tr key={ index }>
          <td className="user">
            <div className="avatar"></div>

            <div className="info">
              <div className="name">{ `${ user.firstName } ${ user.firstName }` }</div>
              <div className="email">{ user.email }</div>
            </div>
          </td>

          <td> user.dateAdded</td>
          <td>{ /* TODO user.lastActive*/'13.3.2026' }</td>

          <td className="menu">⋮</td>
        </tr>
      )) }
    </StandardTable>
  );
};

export default UserTable;