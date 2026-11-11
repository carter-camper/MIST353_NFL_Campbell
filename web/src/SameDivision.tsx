import { useEffect, useState } from 'react';
import { Button } from '@astryxdesign/core/Button';
import { fetchData } from './api';

type Team = { TeamName: string; Conference: string; Division: string };

export default function SameDivision() {
  const [allTeams, setAllTeams] = useState<{ TeamID: number; TeamName: string }[]>([]);
  const [team, setTeam] = useState('');
  const [teams, setTeams] = useState<Team[]>([]);
  const [error, setError] = useState('');

  useEffect(() => {
    fetchData('get_all_teams/').then(setAllTeams).catch(e => setError(String(e)));
  }, []);

  async function load() {
    if (!team) return setError('Pick a team first.');
    try {
      setError('');
      setTeams(await fetchData('get_teams_in_same_conference_division_as_specified_team/', { team_name: team }));
    } catch (e) {
      setError(String(e));
    }
  }

  return (
    <div style={{ padding: 24 }}>
      <h2>Teams in the Same Conference and Division</h2>
      <div style={{ display: 'flex', gap: 12, margin: '16px 0' }}>
        <select value={team} onChange={e => setTeam(e.target.value)}>
          <option value="">Select a team</option>
          {allTeams.map(t => <option key={t.TeamID}>{t.TeamName}</option>)}
        </select>
        <Button label="Find Division Rivals" variant="primary" onClick={load} />
      </div>
      {error && <p style={{ color: 'red' }}>{error}</p>}
      {teams.length > 0 && (
        <table>
          <thead><tr><th>Team</th><th>Conference</th><th>Division</th></tr></thead>
          <tbody>
            {teams.map(t => (
              <tr key={t.TeamName}><td>{t.TeamName}</td><td>{t.Conference}</td><td>{t.Division}</td></tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
}