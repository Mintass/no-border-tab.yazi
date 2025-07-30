local function get_sep()
    local inner = th.tabs.sep_inner or { open = "", close = "" }
    local outer = th.tabs.sep_outer or { open = "", close = "" }
    return inner.open, inner.close, outer.open, outer.close
end

return {
    setup = function()
        if not Tabs or type(Tabs.redraw) ~= "function" then return end

        function Tabs:redraw()
            local total = #cx.tabs
            if total == 0 then return {} end

            local ACT_FG, ACT_BG = th.tabs.active.fg, th.tabs.active.bg
            local INA_FG, INA_BG = th.tabs.inactive.fg, th.tabs.inactive.bg
            local IN_OPEN, IN_CLOSE, OUT_OPEN, OUT_CLOSE = get_sep()

            local spans, cur = {}, cx.tabs.idx
            local max_w = math.floor(self:inner_width() / total)

            local function safe_active_fg()
                if ACT_FG == nil or ACT_FG == ACT_BG then
                    return th.tabs.inactive.bg or "gray"
                end
                return ACT_FG
            end

            for i, tab in ipairs(cx.tabs) do
                local first, last = (i == 1), (i == total)
                local active      = (i == cur)

                local tab_bg      = active and ACT_BG or INA_BG
                local tab_fg      = active and safe_active_fg() or INA_FG
                local sep_fg      = tab_bg

                local left_char   = first and OUT_OPEN or IN_OPEN
                local right_char  = last and OUT_CLOSE or IN_CLOSE

                local left_bg     = first and "reset" or INA_BG
                local right_bg    = last and "reset" or INA_BG

                spans[#spans + 1] = ui.Span(left_char):fg(sep_fg):bg(left_bg)

                spans[#spans + 1] = ui.Span(
                    ya.truncate((" %d:%s "):format(i, tab.name), { max = max_w })
                ):fg(tab_fg):bg(tab_bg):bold(active)

                spans[#spans + 1] = ui.Span(right_char):fg(sep_fg):bg(right_bg)
            end

            return { ui.Line(spans):area(self._area) }
        end
    end
}
