import * as React from "react";

function useCategoryFilters(categories) {
  const [filters, dispatch] = React.useReducer(filterReducer, {
    category: null,
    teams: null,
    categoryDetails: null,
  });

  const { activeCategory, activeTeam, activeCategoryDetail } = _getActiveData(filters);

  const categoryOptions = React.useMemo(
    () => _makeCategoryOptions(filters.categoryDetails),
    [filters.categoryDetails]
  );

  const teamOptions = React.useMemo(
    () => _makeTeamOptions(filters.categoryDetails, activeCategory, activeTeam),
    [filters.categoryDetails, activeCategory, activeTeam]
  );

  // Set kategori default sesaat setelah loading
  // Harus jalan cuma sekali di awal ketika belum ada data defaultnya aja
  React.useEffect(() => {
    if (!categories?.length) {
      return;
    }
    dispatch({ type: "INIT", payload: categories });
  }, [categories]);

  const switchCategoryDetail = ({ category, team }) => {
    dispatch({ type: "SWITCH_CATEGORY_DETAIL", payload: { category, team } });
  };

  return {
    categoryOptions,
    activeCategory,
    teamOptions,
    activeTeam,
    activeCategoryDetail,
    categoryDetails: filters.categoryDetails,
    switchCategoryDetail,
  };
}

function filterReducer(state, action) {
  if (action.type === "INIT") {
    return _makeInitialState(state, action.payload);
  }

  if (action.type === "SWITCH_CATEGORY_DETAIL") {
    return {
      ...state,
      category: action.payload.category,
      teams: {
        ...state.teams,
        [action.payload.category]: action.payload.team,
      },
    };
  }

  return state;
}

function _makeInitialState(state, payload) {
  const groupedCategories = _runGrouping(payload);
  const categories = Object.keys(groupedCategories);
  const defaultCategory = state.category || categories[0];
  const defaultTeam = state.teams || _makeDefaultTeamState(groupedCategories, categories);

  return {
    category: defaultCategory,
    teams: defaultTeam,
    categoryDetails: groupedCategories,
  };
}

function _runGrouping(payload) {
  const sortedByName = payload.sort((first, then) => first.id - then.id);
  return _groupByFilters(sortedByName);
}

function _groupByFilters(data) {
  const categoryDetails = {};
  for (const categoryDetail of data) {
    if (!categoryDetail.isShow) {
      continue;
    }
    const category = _getCategoryName(categoryDetail.labelCategory);
    const team = categoryDetail.teamCategoryId;
    if (!categoryDetails[category]) {
      categoryDetails[category] = {};
    }
    if (!categoryDetails[category][team]) {
      categoryDetails[category][team] = {};
    }
    categoryDetails[category][team] = categoryDetail;
  }
  return categoryDetails;
}

function _getCategoryName(originalLabel) {
  return originalLabel
    .split(" - ")
    .filter((segment, index, segments) => index < segments.length - 1)
    .join(" - ");
}

function _makeDefaultTeamState(groupedCategories, categories) {
  const teamState = {};
  for (const category of categories) {
    teamState[category] = Object.keys(groupedCategories[category])[0];
  }
  return teamState;
}

function _getActiveData(filters) {
  const { category: activeCategory, teams, categoryDetails } = filters;
  const activeTeam = teams?.[activeCategory];
  const activeCategoryDetail = categoryDetails?.[activeCategory]?.[activeTeam] || null;
  return {
    activeCategory,
    activeTeam,
    activeCategoryDetail,
  };
}

function _makeCategoryOptions(data) {
  if (!data) {
    return [];
  }
  const labels = Object.keys(data);
  if (!labels?.length) {
    return [];
  }
  return labels;
}

function _makeTeamOptions(categoryDetails, activeCategory) {
  if (!categoryDetails || !activeCategory) {
    return [];
  }
  const teamFilterLabels = {
    "individu male": "Individu Putra",
    "individu female": "Individu Putri",
    male_team: "Beregu Putra",
    female_team: "Beregu Putri",
    mix_team: "Beregu Campuran",
  };
  const teams = categoryDetails[activeCategory];
  return Object.keys(teams).map((team) => ({
    id: team,
    label: teamFilterLabels[team],
  }));
}

export { useCategoryFilters };
