import * as React from "react";
import { useFetcher } from "hooks/alt-fetcher";
import { GeneralService } from "services";

function useClubRanksByEvent({ eventId, type, params }) {
  const fetcher = useFetcher();

  React.useEffect(() => {
    if (!eventId) {
      return;
    }

    fetcher.runAsync(() => {
      return GeneralService.getClubRanksByEvent({ event_id: eventId, type, ...params });
    });
  }, [eventId, type, params]);

  return fetcher;
}

export { useClubRanksByEvent };
